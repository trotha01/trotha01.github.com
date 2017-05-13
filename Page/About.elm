module Page.About exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p)
import Html.Attributes
import Route
import Page.Header as Header


-- MODEL


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = HeaderMsg Header.Msg


update : Msg -> Model -> Model
update msg model =
    model



-- View


view : Model -> Html Msg
view model =
    div [] [ about ]



{-
   p [] [ Html.text "As a pedagogy enthusiast, I understand the best way to learn is not through lectures and not through reading a book, but through interactivity. So I my dream is to design and create educational games." ]
-}


about : Html msg
about =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ p []
            [ Html.text "My name is Trevor Rothaus, I'm a computer programmer, a pedagogy enthusiast and my passion is in improving education." ]
        , p [] [ Html.text "I grew up in Orange County, California, moved to Boston for college at Tufts University, then moved back to Orange County for a career in software." ]
        , p [] [ Html.text "Like most kids, I grew up spending the majority of my time sitting in a classroom. I knew there had to be a better way to learn. I spent time trying to figure out how I wanted to make an impact on the education world, so I can improve the experience for others. I first thought websites would be the way to go, filled with educational content and a place for both teachers and students to ask questions and have discussions. I learned that the best way to learn anything is through interaction and immersion, so I decided making games would be the best way to go. Making online games would have the greatest potential reach." ]
        , p [] [ Html.text "I do not want to get kids hooked on computers at a young age. I believe young kids should be running around outside, playing with physical objects, learning about the physical world. I do not want to stunt their development with a computer screen. That is why I would want to aim my educational games at students in high school, college, and for continuous learners." ]
        , p [] [ Html.text "I do not want to get kids hooked on computers at a young age. I believe young kids should be running around outside, playing with physical objects, learning about the physical world. I do not want to stunt their development with a computer screen. That is why I would want to aim my educational games at students in high school, college, and for continuous learners." ]
        , p [] [ Html.text "While I believe there is much room for improvement in the young education system, I do not believe that computer games are the complete answer. I believe they will be a good supplement to teachers and courses. Nothing can replace the quality of the in-person teaching, learning, and discussions. But if you do not have access to that, educational games can help. If you do have access to that, educational games will be a positive supplement." ]
        , p [] [ Html.text "So far I have not found online educational games for adults that will get you hooked and make you want to learn. That is my goal. (If you know of any, please send them my way)" ]
        , p [] [ Html.text "I have geared my decisions for this goal and have spend the majority of my free time working towards it. I chose Computer Science as my degree in college so I could learn how to make educational websites. Now I have am learning how to make online games. I read papers like The Montessori Method and _, to see different teaching strategies. I meet up with a game development group, an elm programming group, and a functional programming group, so I can make a stable platform for a game that I can quickly iterate new features on. I teach a classroom of teenagers, because reading about the experience is not enough, I know I must immerse myself to fully understand what it's like to teach. I use these experiences to learn and grow and so I can make the best educational games out there." ]
        , p [] [ Html.text "I aim to offer games that get you hooked from the start. Games that make you want to learn. Games that make you learn without even knowing that you are learning. If you are interested in joining me on the journey, please reach out to me." ]
        ]



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)
