module Main exposing (Msg(..), main, update, view)

import Browser
import Data exposing (Course)
import Html exposing (Html, b, br, div, h2, input, span, td, text, tr)
import Html.Attributes exposing (id, placeholder)
import Html.Events exposing (onInput)
import Json.Decode exposing (decodeString)
import List exposing (length)
import Request exposing (DumpData(..))


type alias Model =
    { data : List Course
    , queryStr : Maybe String
    , filteredCourses : List Course
    , debug : Bool
    }


type Msg
    = RequestData DumpData
    | ChangeStudentQuery String


main : Program Bool Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


init : Bool -> ( Model, Cmd Msg )
init debug =
    ( { data = []
      , queryStr = Nothing
      , filteredCourses = []
      , debug = debug
      }
    , Cmd.map RequestData (Request.fetchData debug)
    )


isStudentMember : String -> Course -> Bool
isStudentMember studentInfo course =
    List.any
        (\s -> String.toLower s.name == studentInfo || s.studentID == studentInfo)
        course.students


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        --
        RequestData response ->
            case response of
                JSON result ->
                    let
                        data =
                            Result.withDefault "JSON Error" result
                                |> decodeString Data.dataDecoder
                                |> Result.toMaybe
                                |> Maybe.withDefault []
                    in
                    ( { model | data = data }, Cmd.none )

        ChangeStudentQuery query ->
            let
                filtered =
                    List.filter (\course -> isStudentMember query course) model.data
                        |> List.sortBy .semester

                queryStr =
                    Just (String.toLower query)
            in
            ( { model | queryStr = queryStr, filteredCourses = filtered }, Cmd.none )


tableHeaderRow : Html Msg
tableHeaderRow =
    tr [ id "table" ]
        [ td [] [ text "Semestre" ]
        , td [] [ text "Código" ]
        , td [] [ text "Turma" ]
        , td [] [ text "Matéria" ]
        ]


dataRow : Course -> Html Msg
dataRow course =
    tr []
        [ td [] [ text course.semester ]
        , td [] [ text course.code ]
        , td [] [ text course.class ]
        , td [] [ text course.name ]
        ]


filteredCoursesText : Int -> String
filteredCoursesText length =
    if length > 0 then
        "Resultados com a informação dada: " ++ String.fromInt length ++ "."

    else
        "Sem resultados, preencha com matrícula ou nome completo."


view : Model -> Html Msg
view model =
    let
        searchInput =
            input [ id "search", placeholder "Nome ou Matrícula de professor ou aluno", onInput ChangeStudentQuery ]
                []

        header =
            div [ id "header" ]
                [ h2 [] [ text "CAGR Dump" ]
                , div []
                    [ b [] [ text "Inclui matérias com código INE, MTM e EEL" ]
                    , br [] []
                    , searchInput
                    ]
                ]

        coursesRow =
            List.map dataRow model.filteredCourses

        filteredCourses =
            List.length model.filteredCourses

        tableInfo =
            div []
                [ text (filteredCoursesText filteredCourses)
                ]

        tableHeader =
            if filteredCourses > 0 then
                tableHeaderRow

            else
                span [] []

        table =
            tableInfo
                :: tableHeader
                :: coursesRow
    in
    div []
        [ header
        , div [ id "content" ]
            table
        ]
