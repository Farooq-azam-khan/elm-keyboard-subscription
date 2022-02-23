module Main exposing (main)

import Browser 
import Browser.Events exposing (onKeyPress)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Decode as Decode 



type alias Model = Int

type Msg 
    = KeyPressed 
    | CharacterKey Char 
    | ControlKey String 

init : () -> (Model, Cmd Msg)
init _ =
    (1, Cmd.none)



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        KeyPressed -> (model + 1, Cmd.none) 
        CharacterKey 'i' -> 
            (model + 1, Cmd.none)
        CharacterKey 'd' ->
            (model - 1, Cmd.none)
        _ -> (model, Cmd.none) 
       


view : Model -> Html Msg
view model =
    div [] [text (String.fromInt model)]

subscriptions : Model -> Sub Msg 
subscriptions model = 
    onKeyPress keyDecoder -- (Decode.succeed KeyPressed)
    
    
keyDecoder : Decode.Decoder Msg 
keyDecoder = 
    Decode.map toKey (Decode.field "key" Decode.string)

toKey : String -> Msg 
toKey keyValue = 
    let
        _ = Debug.log "key value" keyValue 
    in 
    case String.uncons keyValue of 
        Just (char, "") -> 
            CharacterKey char
        _ -> ControlKey keyValue 


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions 
        }
