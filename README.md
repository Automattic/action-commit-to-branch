# Commit and push to remote branch

This action will commit and push to a specific remote branch. 

## Inputs

### `branch`

**Required** The branch name of the branch to commit and push to. 

If the branch does not already exist, it will be created for you. 

### `commit_message`

Custom commit message. **default** "Automated commit from action""

### `add`

The arguments for the `git add` command

## Example usage
```
- name: Push to built branch
  uses: Automattic/action-commit-to-branch@master
  with:
    branch: 'master-built'
    commit_message: 'Build master'
    add: 'build --force'
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # Required
```
