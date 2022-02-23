-- elm install ohanhi/keyboard

module Main exposing (main)
import Keyboard.Arrows
import Browser 
import Browser.Events exposing (onKeyDown)
import Html exposing (Html, button, div, text, li, ul)
import Json.Decode as Decode 
import Keyboard exposing (Key(..), KeyParser, RawKey)



type alias Model = 
    {active_menu: List String, selected_index:Int}

type Msg 
    = KeyUp RawKey | KeyDown RawKey | NoOp

init : () -> (Model, Cmd Msg)
init _ =
    ({selected_index=0, active_menu=["Login", "Signup", "Dashboard"]}, Cmd.none)



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp -> (model, Cmd.none)
        KeyUp _ -> (model, Cmd.none) 
        KeyDown raw_key -> 
            let 
                _ = Debug.log "key" (Keyboard.rawValue raw_key)
            in
                case Keyboard.rawValue raw_key of 
                    "ArrowUp" ->
                        if model.selected_index <= 0 then 
                            (model, Cmd.none)
                        else 
                            ({model | selected_index = model.selected_index - 1}, Cmd.none)
                            
                    "ArrowDown" -> 
                        if model.selected_index >= List.length model.active_menu then 
                            (model, Cmd.none)
                        else 
                            ({model | selected_index = model.selected_index + 1}, Cmd.none)
                    _ -> (model, Cmd.none)
       


view : Model -> Html Msg
view model =
    div [] 
        [ul [] (List.map (\el -> li [] [text el]) model.active_menu)
        , text <| "Selected item: " ++ String.fromInt model.selected_index
        ]

    
subscriptions : Model -> Sub Msg 
subscriptions model = 
    Sub.batch 
        [ Keyboard.downs KeyDown
        , Keyboard.ups KeyUp 
        ] 
    


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions 
        }
