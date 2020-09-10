# PowerShell Scripts To Rule Them All

PowerShell scripts loosely based on GitHub's
[scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all).

I don't feel that all of these scripts need to be called directly so I am moving some of them into a
`bin` subfolder to allow reuse without cluttering up the main `script` folder.

This is early days and so not all scripts will be implemented until I have an actual need for them.

## The Scripts

The following is a list of scripts and their primary responsibilities.

### [script/setup][setup]

Used to set up a project in an initial state.
This is typically run after an initial clone, or, to reset the project back to its initial state.

### [script/update][update]

Used to update the project after a fresh pull.
This should include any database migrations or any other things required to get the state of the
app into shape for the current version that is checked out.

### [script/update][update]

Used to update the project after a fresh pull.
This should include any database migrations or any other things required to get the state of the
app into shape for the current version that is checked out.

### [script/test][test]

Used to run the test suite of the project.
To allow this script to be run from CI setup should be done outside of this script.
A manual call to [update][update] before running the tests is usually a good idea.

A good pattern to support is having optional arguments that allow you to run specific tests.

Linting is also be considered a form of testing.
These tend to run faster than tests, so put them towards the beginning so it fails faster if
there's a linting problem.

## Installing Dependencies

The [bootstrap][bootstrap] script, called from both [setup][setup] and [update][update] scripts,
is used solely for fulfilling dependencies of the project.
This can mean installing packages, updating git submodules, etc.
The goal is to make sure all required dependencies are installed.

This script currently allows for following package managers:

### [Chocolatey](https://chocolatey.org/)

If you have some [Chocolatey](https://chocolatey.org/) packages required then you can simply add a
`chocolatey-packages` file at the top level of the project with a list of the packages and they
will be installed and updated as required.

### [winget](https://github.com/microsoft/winget-cli)

Microsoft has recently released it's own package manager
[winget](https://github.com/microsoft/winget-cli).
This is currently only a preview so some functionality may not be available yet but it sounds
promising so if you want to use this to install some packages then you can simply add a
`winget-packages` file at the top level of the project with a list of the packages and they will be
installed and updated as required.

[bootstrap]: script/bin/bootstrap.ps1
[setup]: script/setup.ps1
[test]: script/test.ps1
[update]: script/update.ps1
