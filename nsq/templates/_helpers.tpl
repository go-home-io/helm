{{- define "lookup.name" -}}
{{- default .Chart.Name "nsqlookup" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nsqd.name" -}}
{{- default .Chart.Name "nsqd" | trunc 63 | trimSuffix "-" -}}
{{- end -}}