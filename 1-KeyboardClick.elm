module Main exposing (main)

import Browser 
import Browser.Events exposing (onKeyPress)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Decode as Decode 



type alias Model = Int

type Msg = KeyPressed 

init : () -> (Model, Cmd Msg)
init _ =
    (1, Cmd.none)



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        KeyPressed -> (model + 1, Cmd.none) 
       


view : Model -> Html Msg
view model =
    div [] [text (String.fromInt model)]

subscriptions : Model -> Sub Msg 
subscriptions model = 
    onKeyPress (Decode.succeed KeyPressed)
    
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions 
        }
