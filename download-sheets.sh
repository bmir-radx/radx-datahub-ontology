#!/bin/bash

# Set your Google Spreadsheet ID here
SPREADSHEET_ID="11R-eoe8OUDU3OKnWir7v-_ihfQnJz7rPQrVHSHTJ-0Y"

# Declare an array of sheet names
sheet_names=(
  "Data terms"
  "DCC terms"
  "Data element terms"
  "File terms"
  "Misc terms"
  "Individuals"
  "Media types"
)

# Loop through each sheet name
for name in "${sheet_names[@]}"; do
  # URL-encode the sheet name for use in a query parameter
  encoded_name=${name// /%20}

  # Construct download URL
  url="https://docs.google.com/spreadsheets/d/${SPREADSHEET_ID}/gviz/tq?tqx=out:csv&sheet=${encoded_name}"
       https://docs.google.com/spreadsheets/d/11R-eoe8OUDU3OKnWir7v-_ihfQnJz7rPQrVHSHTJ-0Y/gviz/tq\?tqx\=out:csv\&sheet\=Individuals
  # Create a filename based on the sheet name (replace spaces with underscores)
  filename=$(echo "$name" | tr ' ' '-' | tr -cd '[:alnum:]_-').csv

  echo "Downloading '$name' as $filename..."
  curl -L --fail -o "$filename" "$url"

  if [ $? -ne 0 ]; then
    echo "Failed to download sheet: $name"
  fi
done
