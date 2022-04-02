# cagdump

Dados extraídos do [CAGR](https://cagr.sistemas.ufsc.br/) em formato JSON.

#### JSON Structure:

Campo|Descrição
-|-
`name`|Nome da matéria ex: Paradigmas de Programação
`code`|Código da disciplina ex: INE5401
`class`|Código de turma ex: 04208A
`semester`|Semestre da disciplina
`students`|Lista de estudantes (ver extrutura abaixo)

Estudante:
Campo|Descrição
-|-
`name`|Nome do estudante
`student_id`|Matrícula do estudante
`type`|Enum: `student`, `teacher` or `monitor`
```
