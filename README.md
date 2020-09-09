# PowerShell Scripts To Rule Them All

PowerShell scripts loosely based on GitHub's [scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all).

I don't feel that all of these scripts need to be called directly so I am moving some of them into a
`bin` subfolder to allow reuse without cluttering up the main `script` folder.

This is early days and so not all scripts will be implemented until I have an actual need for them.

## The Scripts

### [script/setup](script/setup.ps1)

Used to set up a project in an initial state.
This is typically run after an initial clone, or, to reset the project back to its initial state.

### [script/update](script/update.ps1)

Used to update the project after a fresh pull.
This should include any database migrations or any other things required to get the
state of the app into shape for the current version that is checked out.

## Required Packages

The [bootstrap](script/bin/bootstrap.ps1) script, called from both [setup](script/setup.ps1) and [update](script/update.ps1) scripts, allows for different package managers.

### [Chocolatey](https://chocolatey.org/)

If you have some [Chocolatey](https://chocolatey.org/) packages required then you can simply add a `chocolatey-packages` file at the top level of the project with a list of the packages and they will be installed and updated as required.

### [winget](https://github.com/microsoft/winget-cli)

Microsoft has recently released it's own package manager [winget](https://github.com/microsoft/winget-cli).
This is currently only a preview so some functionality may not be available yet but it sounds promising so if you want to use this to install some packages then you can simply add a `winget-packages` file at the top level of the project with a list of the packages and they will be installed and updated as required.
