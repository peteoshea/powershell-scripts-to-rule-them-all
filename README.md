# PowerShell Scripts To Rule Them All

[![CI](https://github.com/peteoshea/powershell-scripts-to-rule-them-all/workflows/CI/badge.svg)](https://github.com/peteoshea/powershell-scripts-to-rule-them-all/actions)

PowerShell scripts loosely based on GitHub's [scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all).

I did not have a reason to call the [bootstrap][bootstrap] script directly so I have moved it into a `bin` subfolder to allow reuse without cluttering up the main `script` folder.

The `cibuild` script didn't really make sense to me as different CI systems have different requirements so I have removed it.
As an example the [test][test] script is called directly from the [ci.yml][ci.yml] GitHub action.

As for the `server` and `console` scripts then I haven't had a need for them yet so I've just removed them for now.
I will recreate them as bash scripts if and when I have a need for them.

I have also created bash versions of the [scripts-to-rule-them-all](https://github.com/peteoshea/scripts-to-rule-them-all) with my take on things.

## The Scripts

The following is a list of scripts and their primary responsibilities.

### [script/setup][setup]

Used to set up a project in an initial state.
This is typically run after an initial clone, or, to reset the project back to its initial state.

### [script/update][update]

Used to update the project after a fresh pull.
This should include any database migrations or any other things required to get the state of the app into shape for the current version that is checked out.

### [script/test][test]

Used to run the test suite of the project.
To allow this script to be run from CI setup should be done outside of this script.
A manual call to [update][update] before running the tests is usually a good idea.

A good pattern to support is having optional arguments that allow you to run specific tests.

Linting is also be considered a form of testing.
These tend to run faster than tests, so put them towards the beginning so it fails faster if there's a linting problem.

## Installing Dependencies

The [bootstrap][bootstrap] script, called from both [setup][setup] and [update][update] scripts, is used solely for fulfilling dependencies of the project.
This can mean installing packages, updating git submodules, etc.
The goal is to make sure all required dependencies are installed.

This script currently allows for following package managers:

### [Chocolatey](https://chocolatey.org/)

If you have some [Chocolatey](https://chocolatey.org/) packages required then you can simply add a
`chocolatey-packages` file at the top level of the project with a list of the packages and they
will be installed and updated as required.
Simply having the `chocolatey-packages` file means Chocolatey will be installed and updated.

### [winget](https://github.com/microsoft/winget-cli)

Microsoft has recently released it's own package manager
[winget](https://github.com/microsoft/winget-cli).
This is currently only a preview so some functionality may not be available yet but it sounds
promising so if you want to use this to install some packages then you can simply add a
`winget-packages` file at the top level of the project with a list of the packages and they will be
installed and updated as required.

[bootstrap]: script/bin/bootstrap.ps1
[ci.yml]: .github/wokflows/ci.yml
[setup]: script/setup.ps1
[test]: script/test.ps1
[update]: script/update.ps1
