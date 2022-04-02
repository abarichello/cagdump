module Data exposing (Course, Student, studentDecoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Field as Field


type alias Course =
    { name : String
    , code : String
    , class : String
    , semester : String
    , students : List Student
    }


type alias Student =
    { name : String
    , studentID : String
    }


courseDecoder : Decoder Course
courseDecoder =
    -- elm-format gives me no way to format this properly
    Field.require "name" Decode.string <|
        \name ->
            Field.require "code" Decode.string <|
                \code ->
                    Field.require "class" Decode.string <|
                        \class ->
                            Field.require "semester" Decode.string <|
                                \semester ->
                                    Field.require "students" (Decode.list studentDecoder) <|
                                        \students ->
                                            Decode.succeed
                                                { name = name
                                                , code = code
                                                , class = class
                                                , semester = semester
                                                , students = students
                                                }


studentDecoder : Decoder Student
studentDecoder =
    Field.require "name" Decode.string <|
        \name ->
            Field.require "student_id" Decode.string <|
                \studentID ->
                    Decode.succeed
                        { name = name
                        , studentID = studentID
                        }
