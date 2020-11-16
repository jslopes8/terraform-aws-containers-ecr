{
    "rules": [
        {
            "rulePriority": ${rulePriority},
            "description": "${ruleDescription}",
            "selection": {
                "tagStatus": "${ruleTagStatus}",
                "tagPrefixList": ["${ruleTagPrefixList}"],
                "countType": "${ruleCountType}",
                "countNumber": ${ruleCountNumber}
            },
            "action": {
                "type": "${ruleActionType}"
            }
        }
    ]
}
