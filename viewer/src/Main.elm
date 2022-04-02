module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, div, embed, input, text)
import Html.Attributes exposing (height, id, placeholder, src, width)
import Html.Events exposing (onInput)


type alias Model =
    { queryStr : Maybe String
    }


type Msg
    = ChangeStudentQuery String


main : Program () Model Msg
main =
    Browser.element
        { init = \() -> init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( { queryStr = Nothing }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeStudentQuery query ->
            ( { model | queryStr = Just query }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        header =
            div [ id "header" ]
                [ text "CAGR Dump"
                , input [ id "search", placeholder "Nome ou Matrícula de professor/aluno", onInput ChangeStudentQuery ] []
                ]
    in
    div []
        [ header
        , div [ id "content" ]
            []
        ]
