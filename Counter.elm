module Counter exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)

type alias Model = Int

type Msg
    = Inc
    | Decr

model : Model
model = 0

update : Msg -> Model -> Model
update msg model =
    case msg of
        Inc ->
            model + 1
        Decr ->
            model - 1

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Inc ] [ text "+"]
        , text (toString model)
        , button [ onClick Decr] [ text "-"]
        ]

main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
