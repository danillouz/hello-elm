module Basic exposing (..)

import Html exposing (Html, text)

reverseStr : String -> String
reverseStr s = String.reverse s

type alias User =
    { id: Int
    , name: String
    }

daniel = User 1 "Daniel Illouz"

main =
    text (.name daniel |> reverseStr)
