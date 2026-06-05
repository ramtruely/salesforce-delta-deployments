

--
echo "Target Sandbox: $SANDBOX"

echo "Checking merged PR history for base branch: $Basebranch"

MERGED_PR_COUNT=$(curl -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/${GITHUB_REPO}/pulls?state=closed&base=${Basebranch}&per_page=100" \
  | jq '[.[] | select(.merged_at != null)] | length')

echo "Merged PR Count: $MERGED_PR_COUNT"

if [ "$MERGED_PR_COUNT" -gt 0 ]; then

    echo "Merged PR detected for base branch '$Basebranch'"
    echo "Environment has already been used."

    is_first_active_pr="false"

else

    echo "No merged PR found."
    echo "Checking active PR count for base branch: $Basebranch"

    OPEN_PR_COUNT=$(curl -s \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      "https://api.github.com/repos/${GITHUB_REPO}/pulls?state=open&base=${Basebranch}" \
      | jq 'length')

    echo "Open PR Count: $OPEN_PR_COUNT"

    if [ "$OPEN_PR_COUNT" -eq 1 ]; then
        is_first_active_pr="true"
        echo "First Active PR detected"
    else
        is_first_active_pr="false"
        echo "Not First Active PR"
    fi

fi

echo "Merged PR Count for base branch '$Basebranch': $MERGED_PR_COUNT"
echo "First active PR targeting this branch: $is_first_active_pr"

echo "is_first_active_pr=${is_first_active_pr}" >> $GITHUB_ENV
echo "is_first_active_pr=${is_first_active_pr}" >> $GITHUB_OUTPUT

echo "IS_ORG_DEP=${PACKAGE_TYPE}" >> $GITHUB_ENV
echo "IS_ORG_DEP=${PACKAGE_TYPE}" >> $GITHUB_OUTPUT
--

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
