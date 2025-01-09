# DefectDojo CLI Upload Action

This Github Action uses the [DefectDojo CLI](https://github.com/Digitalist-Open-Cloud/DefectDojo-CLI) to upload test results to a DefectDojo instance.

The action tuns the command `defectdojo reimport_scan upload INPUTS`

(INPUTS being what you provide in the action as command)

The recommended way to use this action is to use environment variables as much as possible to not expose information by mistake. See the DefectDojo CLI repo for environment variables supported.
