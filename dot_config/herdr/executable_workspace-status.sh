#!/bin/sh
# Print the active workspace name for the herdr tab bar, as <name> in bold.
# herdr strips escape codes from status output, so "bold" uses the Unicode
# Mathematical Sans-Serif Bold letters and digits instead.
"$HERDR_BIN_PATH" workspace get "$HERDR_ACTIVE_WORKSPACE_ID" | jq -r '
  .result.workspace.label
  | explode
  | map(
      if   . >= 65 and . <= 90  then . - 65 + 120276  # A-Z -> U+1D5D4
      elif . >= 97 and . <= 122 then . - 97 + 120302  # a-z -> U+1D5EE
      elif . >= 48 and . <= 57  then . - 48 + 120812  # 0-9 -> U+1D7EC
      else . end)
  | implode
  | "<\(.)>"'
