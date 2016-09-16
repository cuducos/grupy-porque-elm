module Main exposing (..)

import Html exposing (br, button, div, form, input, p, text, textarea)
import Html.App
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onSubmit)


main : Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }



--
-- Model
--


type alias Comment =
    { author : String
    , contents : String
    }


type alias Model =
    { new : Comment
    , comments : List Comment
    }


initialModel : Model
initialModel =
    { new =
        { author = ""
        , contents = ""
        }
    , comments = []
    }


initialModel2 : Model
initialModel2 =
    { new =
        { author = "John Doe"
        , contents = "Ahoy, cap'n"
        }
    , comments =
        [ { author = "Joane Doe"
          , contents = "What be happenin', matey?"
          }
        , { author = "Buccaneer"
          , contents = "What say ye, ya scurvy dog?"
          }
        ]
    }



--
-- Update
--


type Msg
    = UpdateAuthor String
    | UpdateContents String
    | PostComment


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateAuthor value ->
            let
                new =
                    model.new

                updated =
                    { new | author = value }
            in
                { model | new = updated }

        UpdateContents value ->
            let
                new =
                    model.new

                updated =
                    { new | contents = value }
            in
                { model | new = updated }

        PostComment ->
            let
                comments =
                    List.append model.comments [ model.new ]
            in
                { model | new = Comment "" "", comments = comments }



--
-- View
--


pluralize : Int -> String
pluralize count =
    if count == 1 then
        "comentário"
    else
        "comentários"


viewComment : Comment -> Html.Html Msg
viewComment comment =
    p
        []
        [ text (comment.author ++ ":")
        , br [] []
        , text comment.contents
        ]


view : Model -> Html.Html Msg
view model =
    let
        count =
            List.length model.comments

        phrase =
            (toString count) ++ " " ++ pluralize count
    in
        div
            []
            [ p [] [ text phrase ]
            , div [] (List.map viewComment model.comments)
            , form
                [ onSubmit PostComment ]
                [ input [ value model.new.author, onInput UpdateAuthor ] []
                , br [] []
                , textarea [ value model.new.contents, onInput UpdateContents ] []
                , br [] []
                , button [] [ text "Enviar" ]
                ]
            ]
