#!/bin/bash
set -e

#check for command line args 
if [ -z $1 ]
then
    option="unknown"
elif [ -n $1 ]
then
    option=$1
fi

array_of_regions=(default us-east-1 ap-southeast-1 ap-southeast-2 sa-east-1)

terraform_execute () {
    command=$1
    for region in ${array_of_regions[*]} 
    do
        printf "Selecting region :  %s\n" $region
        set +e
        terraform workspace select $region
        retVal=$?
        if [ $retVal -ne 0 ]; then
            printf "creating and switching to new workspace :  %s\n" $region
            terraform workspace new $region
            if [[ $(terraform workspace show) != $region ]]; then
                printf "Something is wrong with workspace switch for %s \n" $region
                continue
            fi
        fi
        set -e    
        
        if [ "$command" = "plan" ]
        then
            terraform $command -out=$region-tfplan.tmp
        else
            terraform $command $region-tfplan.tmp
        fi
        printf "Done\n"
        printf "################################################################ \n"
    done
}

case $option in
    "plan")
        terraform_execute plan
        ;;
    "apply")
        terraform_execute apply
        ;;
    *)  
        printf "Invalid arguments, please check!"
        ;;
esac