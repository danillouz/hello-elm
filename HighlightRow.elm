module HighlightRow exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Keyboard exposing (presses, KeyCode)

type alias Row =
    { position: Int
    , text: String
    }

type alias Rows = List Row

type alias Model =
    { currentIndex: Int
    , rows: Rows
    }

type Msg = KeyPress Int

init : (Model, Cmd Msg)
init =
    (Model 0 [ (Row 0 "Foo"), (Row 1 "Bar"), (Row 2 "Baz") ], Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = (presses KeyPress)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        KeyPress code ->
            let
                max = List.length model.rows - 1
                result =
                    case code of
                        38 ->
                            if model.currentIndex < max then
                                model.currentIndex + 1
                            else 0

                        40 ->
                            if model.currentIndex > 0 then
                                model.currentIndex - 1
                            else max

                        _ ->
                            model.currentIndex
            in
                ({ model | currentIndex = result }, Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [ text ("Selected row index " ++ (toString model.currentIndex))
        , viewRows model
        ]

viewRows : Model -> Html Msg
viewRows model =
    let
        getRow = viewRow model.currentIndex
    in
        div [ style [ ("width", "800px") ] ]
            (List.map getRow model.rows)

viewRow : Int -> Row -> Html Msg
viewRow selectedIndex row =
    let
        basicStyle = [ ("width", "200px") ]
        getStyle index =
            if index == selectedIndex then
                List.append basicStyle [ ("color", "red") ]
            else
                basicStyle
    in
        div [ style (getStyle row.position) ]
            [ text row.text ]

main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
