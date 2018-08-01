{{- define "smartthings.name" -}}
{{- default .Chart.Name "smartthings" | trunc 63 | trimSuffix "-" -}}
{{- end -}}