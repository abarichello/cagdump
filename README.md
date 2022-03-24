# cagdump

Dump data from [CAGR](https://cagr.sistemas.ufsc.br/) into a JSON file for analysis.

#### JSON Structure:

Field|Description
-|-
`name`|Nome da matéria ex: Paradigmas de Programação
`code`|Código da disciplina ex: INE5401
`class`|Código de turma ex: 04208A
`semester`|Semestre da disciplina
`students`|Lista de estudantes (ver extrutura abaixo)

Estudante:
Field|Description
-|-
`name`|Nome do estudante
`student_id`|Matrícula do estudante
`type`|Enum: `student`, `teacher` or `monitor`
```
