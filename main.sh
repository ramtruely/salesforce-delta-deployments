echo "Current PR Number: $PR_NUMBER"

if [ "$PR_NUMBER" -eq 1 ]; then
    first_pr="yes"
    echo "First PR detected"
else
    first_pr="no"
fi

echo "first_pr=$first_pr" >> $GITHUB_ENV
echo "first_pr=$first_pr" >> $GITHUB_OUTPUT

echo "First PR Flag: $first_pr"

---
needs.pre-requisite.outputs.first_pr != 'yes'

--
outputs:
  first_pr:
    description: "Indicates whether current PR is the first PR"
    value: ${{ env.first_pr }}
--
outputs:
  is_org_dep: ${{ env.IS_ORG_DEP }}
  sandbox: ${{ env.SANDBOX }}
  runner: ${{ env.runner }}
  main_code: ${{ env.main_code }}
  apex_code: ${{ env.classes_changed }}
  lwc_code: ${{ env.lwc_code }}
  is_merge_pr: ${{ env.is_merge_pr }}
  first_pr: ${{ env.first_pr }}
  SKIP_PRETTIER_VALIDATION: ${{ steps.export_env_vars.outputs.SKIP_PRETTIER_VALIDATION }}
