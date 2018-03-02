module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { projects : List Project }


type alias Project =
    { title : String
    , description : String
    , link : String
    , coverImg : String
    }


init : ( Model, Cmd Msg )
init =
    ( { projects = initProjects }, Cmd.none )


initProjects : List Project
initProjects =
    [ { title = "Boxes and Bubles"
      , description = "Built on top of Jastice's library (also called boxes-and-bubbles); this is an exporation into collision detection with, as the name implies, boxes and bubbles."
      , link = "https://github.com/trotha01/boxes-and-bubbles"
      , coverImg = "imgs/boxesandbubbles.png"
      }
    , { title = "Bee Game"
      , description = "Learn Spanish while traveling around the world as a bee."
      , link = "https://github.com/trotha01/bee"
      , coverImg = "imgs/beegame.png"
      }
    , { title = "Safety Bubble"
      , description = "Elm February Game Jam Result"
      , link = "https://github.com/trotha01/safetybubble"
      , coverImg = "imgs/safetybubble.png"
      }
    , { title = "Treadmill"
      , description = "Practice your spanish while making a cake."
      , link = "https://github.com/trotha01/treadmill"
      , coverImg = "imgs/treadmill.png"
      }
    ]



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ -- navigationSection model
          headerSection model
        , mainSection model
        , footerSection model
        ]


navigationSection : Model -> Html Msg
navigationSection model =
    text "navigation"


headerSection : Model -> Html Msg
headerSection model =
    header [ class "header" ]
        [ h1 [ class "heading-primary" ]
            [ span [ class "heading-primary--main" ] [ text "Trevor Rothaus" ]
            , span [ class "heading-primary--sub1" ] [ text "Pedagogy Enthusiast" ]
            , span [ class "heading-primary--sub2" ] [ text "Software Engineer" ]
            ]
        ]


mainSection : Model -> Html Msg
mainSection model =
    main_ []
        [ parallax "imgs/bookshelf.jpg"
        , aboutSection model
        , parallax "imgs/tools.jpg"
        , projectsSection model
        , parallax "imgs/bookstack.jpg"
        , resumeSection model
        , parallax "imgs/paper.jpg"
        , contactSection model
        ]


aboutSection : Model -> Html Msg
aboutSection model =
    section [ class "about" ]
        [ h2 [ class "heading-secondary" ]
            [ text "about" ]
        , p [ class "section-text" ]
            [ text "lorem ipsum dolor sit amet consectetur adipisicing elit. Aperiam, ipsum sapiente aspernatur libero repellat quis consequatur ducimus quam nisi exercitationem omnis earum qui."
            ]
        ]


projectsSection : Model -> Html Msg
projectsSection model =
    section [ class "projects" ]
        [ h2 [ class "heading-secondary" ] [ text "projects" ]
        , div [] (List.map viewProject model.projects)
        ]


viewProject : Project -> Html Msg
viewProject project =
    a [ class "project button", href project.link, target "_blank" ]
        [ div [] [ img [ class "project-image", src project.coverImg ] [] ]
        , h3 [ class "heading-tertiary" ] [ text project.title ]
        , text project.description
        ]


resumeSection : Model -> Html Msg
resumeSection model =
    section [ class "resume" ]
        [ h2 [ class "heading-secondary" ] [ text "resume" ]
        , div []
            [ Html.iframe
                [ class "resume--iframe"
                , src "https://docs.google.com/viewer?srcid=1ADJVDEkWIu0BQFGfS6JkJUUgS3mDyhh_lLsTslAUW0E&pid=explorer&efh=false&a=v&chrome=false&embedded=true"
                ]
                []
            ]
        ]


contactSection : Model -> Html Msg
contactSection model =
    section [ class "contact" ]
        [ h2 [ class "heading-secondary" ] [ text "contact" ]
        , div [ class "contact-item" ] [ text "1. trotha01 at gmail" ]
        , a [ class "contact-item", href "https://www.linkedin.com/in/trevorrothaus/", target "_blank" ] [ text "2. LinkedIn" ]
        ]


footerSection : Model -> Html Msg
footerSection model =
    div [ class "footer" ]
        [ div [] [ text "Credits" ]
        , a [ href "https://unsplash.com/photos/HWbxSLvmSww" ] [ text "Paper Photo by Neven Krcmarek on Unsplash" ]
        , a [ href "https://unsplash.com/photos/t5YUoHW6zRo" ] [ text "Tool Photo by Barn Images on Unsplash" ]
        , a [ href "https://unsplash.com/photos/y0Fa1DEKOKspaper" ] [ text "Bookshelf Photo by Samuel Zeller on Unsplash" ]
        , a [ href "https://unsplash.com/photos/tofagMI_UCM" ] [ text "Bookstack Photo by Jan Mellström on Unsplash" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HELPERS


parallax : String -> Html Msg
parallax image =
    div
        [ class "parallax"
        , style
            [ ( "background-image", """url(" """ ++ image ++ """ ")""" )
            , ( "min-height", "500px" )
            , ( "background-attachment", "fixed" )
            , ( "background-position", "center" )
            , ( "background-repeat", "no-repeat" )
            , ( "background-size", "cover" )
            ]
        ]
        []
