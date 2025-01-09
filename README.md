# DefectDojo CLI Upload Action

This Github Action uses the [DefectDojo CLI](https://github.com/Digitalist-Open-Cloud/DefectDojo-CLI) to upload test results to a DefectDojo instance.

The action tuns the command `defectdojo reimport_scan upload ARGS`

(ARGS being what you provide in the action as arguments)

The recommended way to use this action is to use environment variables as much as possible to not expose information by mistake. See the DefectDojo CLI repo for environment variables supported.

## Example usage

`DEFECTDOJO_API_KEY` and `DEFECTDOJO_URL` are saved as secrets in the repo.

```yaml
name: Semgrep OSS scan
on:
  pull_request: {}
  workflow_dispatch: {}
  push:
    branches: ["security_scans"]
env:
  DEFECTDOJO_API_KEY: ${{ secrets.DEFECTDOJO_API_KEY }}
  DEFECTDOJO_URL: ${{ secrets.DEFECTDOJO_URL }}
  DEFECTDOJO_ENGAGEMENT_NAME: "GitHub Action"
  DEFECTDOJO_PRODUCT_NAME: "My product in DefectDojo"
  DEFECTDOJO_COMMIT_HASH: ${GITHUB_SHA}
  DEFECTDOJO_SCAN_TYPE: "Semgrep JSON Report"
  DEFECTDOJO_TEST_TITLE: "Semgrep"
jobs:
  semgrep:
    name: semgrep-oss/scan
    runs-on: ubuntu-24.04
    permissions:
      # required for all workflows
      security-events: write
      # only required for workflows in private repositories
      actions: read
      contents: read
    container:
      image: semgrep/semgrep
    # Skip any PR created by dependabot to avoid permission issues:
    if: (github.actor != 'dependabot[bot]')
    steps:
      - uses: actions/checkout@v4
      - run: semgrep scan --config auto --json -o results.json
      - uses: Digitalist-Open-Cloud/DefectDojo-CLI-Action@1.0.2
        with:
          arguments: '--file results.json'
```
