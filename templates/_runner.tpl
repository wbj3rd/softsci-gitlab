{{/*
Return the gitlab-runner registration token secret name
*/}}
{{- define "gitlab.gitlab-runner.registrationToken.secret" -}}
{{- default (printf "%s-gitlab-runner-secret" .Release.Name) .Values.global.runner.registrationToken.secret | quote -}}
{{- end -}}

{{/*
Override the runner charts secret name containing the tokens so everything matches
*/}}
{{- define "gitlab-runner.secret" -}}
{{ include "gitlab.gitlab-runner.registrationToken.secret" . }}
{{- end -}}

{{/*
Override the runner charts cache secret name to match minio
*/}}
{{- define "gitlab-runner.cache.secret" -}}
{{- if .Values.runners.cache.secretName -}}
{{    .Values.runners.cache.secretName | quote }}
{{- else if .Values.global.minio.enabled -}}
{{    include "gitlab.minio.credentials.secret" . }}
{{- end -}}
{{- end -}}

{{/*
Override runner charts cache.s3ServerAddress value to match minio
*/}}
{{- define "gitlab-runner.cache.s3ServerAddress" -}}
{{ default ( include "gitlab.minio.hostname" . ) .Values.runners.cache.s3ServerAddress | quote }}
{{- end -}}

{{/*
Override runner charts gitlabUrl value
*/}}
{{- define "gitlab-runner.gitlabUrl" -}}
{{- if .Values.gitlabUrl -}}
{{- .Values.gitlabUrl -}}
{{- else -}}
{{- template "gitlab.gitlab.url" . -}}
{{- end -}}
{{- end -}}
