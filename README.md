# PowerShell Scripts To Rule Them All

PowerShell scripts loosely based on GitHub's [scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all).

I don't feel that all of these scripts need to be called directly so I am moving some of them into a
`bin` subfolder to allow reuse without cluttering up the main `powershell` folder.

This is early days and so not all scripts will be implemented until I have an actual need for them.

## The Scripts

### [powershell/setup](powershell/setup.ps1)

Used to set up a project in an initial state.
This is typically run after an initial clone, or, to reset the project back to its initial state.

### [powershell/update](powershell/update.ps1)

Used to update the project after a fresh pull.
This should include any database migrations or any other things required to get the
state of the app into shape for the current version that is checked out.
