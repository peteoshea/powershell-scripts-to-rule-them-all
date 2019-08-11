# PowerShell Scripts To Rule Them All

PowerShell scripts loosely based on GitHub's [scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all).

I don't feel that all of the scripts need to be called directly so I am moving some of the into a
`bin` subfolder to allow reuse without cluttering up the main `script` folder.

This is early days and so not all scripts will be implemented until I have an actual need for them.

## The Scripts

### [script/setup](script/setup.ps1)

This is used to set up a project in an initial state.
This is typically run after an initial clone, or, to reset the project back to its initial state.
