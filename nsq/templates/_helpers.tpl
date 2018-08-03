{{- define "nsqd.name" -}}
{{- default .Chart.Name "nsqd" | trunc 63 | trimSuffix "-" -}}
{{- end -}}