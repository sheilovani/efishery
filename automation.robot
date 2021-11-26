*** Settings ***
Library    Selenium2Library


*** Variables ***
${browser}                      chrome
${url}                          https://music.youtube.com/
${home_btn}                     //*[@tab-id='FEmusic_home']
${explore_btn}                  //*[@tab-id='FEmusic_explore']
${library_btn}                  //*[@tab-id='FEmusic_liked']
${search_btn}                   //*[contains(@class, 'ytmusic-search-box') and text() = 'Search']
${charts_menu}                  //*[contains(@class, 'ytmusic-navigation-button-renderer') and text() = 'Charts']
${search_inputText}             //*[@class='style-scope ytmusic-search-box' and @id='input']
${result_search}                css:a[aria-label="Lewis Capaldi"]
${list_of_song}                 //*[@class='style-scope ytmusic-shelf-renderer' and text()='Songs']
${song_title}                   //a[@href="watch?v=pRIZohFFOMo&list=RDAMVMpRIZohFFOMo"]
${play_pause_button}            //*[@id="play-pause-button"]
${play_button_bottom_bar}       //*[@title='Play']
${skip_ad}                      //*[@class='ytp-ad-skip-button-icon']
${next_button}                  //*[@title='Next song']
${previous_button}              //*[@title='Previous song']

*** Keywords ***
Open Youtube Music website in chrome
    Open Browser                       ${url}                  ${browser}
    Maximize Browser Window

User will see Youtube Music landing home page
    Verify Home button
    Verify Explore button
    Verify Library button
    Verify Search button

User on Home page
    Verify Home button

User on Explore page
    Wait Until Page Contains Element            ${charts_menu}

Verify Home button
    Wait Until Page Contains Element            ${home_btn} 

User will see Explore page
    Wait Until Page Contains Element            ${charts_menu}

Verify Explore button
    Wait Until Page Contains Element            ${explore_btn}

Verify Library button
    Wait Until Page Contains Element            ${library_btn}

Verify Search button
    Wait Until Page Contains Element            ${search_btn}

Click Explore button
    Click Element                               ${explore_btn}
    Sleep                                       2 second

Click Search button
    Click Element                               ${search_btn}
    Sleep                                       2 second

Type a Singer Lewis Capaldi
    Input Text                                  ${search_inputText}             Lewis Capaldi
    Press Keys                                  ${search_inputText}             ENTER    

Lewis Capaldi's Songs Will be Displayed
    Wait Until Page Contains Element            ${result_search}

List of Song
    Wait Until Page Contains Element            ${list_of_song}

Click Song Title
    Set Focus To Element                        ${song_title}
    Click Element                               ${song_title}

The Song Will Play
    Wait Until Page Contains Element            ${play_pause_button}

Song is Playing
    Wait Until Page Contains Element            ${play_pause_button}
    Sleep                                       7 second
    Wait Until Page Contains Element            ${skip_ad}
    Click Element                               ${skip_ad}
    Sleep                                       5 second

The Next Song is Playing
    Wait Until Page Contains Element            ${play_pause_button}
    Sleep                                       3 second

Click Pause button
    Wait Until Page Contains Element            ${play_pause_button}
    Set Focus To Element                        ${play_pause_button}
    Click Element                               ${play_pause_button}

The Song Pause
    Wait Until Page Contains Element            ${play_button_bottom_bar}

Click Next button
    Click Element                               ${next_button}
    Wait Until Page Contains Element            ${play_pause_button}
    Sleep                                       3 second

Click Previous button twice
    Click Element                               ${previous_button}
    Click Element                               ${previous_button}
    Wait Until Page Contains Element            ${play_pause_button}

The Next Song Will Play
    Wait Until Page Contains Element            ${play_pause_button}

The Previous Song Will Play
    Wait Until Page Contains Element            ${play_pause_button}

Close The Browser
    Close Browser

*** Test Cases ***
Open Youtube Music
    Given Open Youtube Music website in chrome
    Then User will see Youtube Music landing home page

Go To Explore Page
    Given User on Home page
    When Click Explore button
    Then User will see Explore page

Search a Singer
    Given User on Explore page
    When Click Search button
    And Type a Singer Lewis Capaldi
    Then Lewis Capaldi's Songs Will be Displayed

Play the Song
    Given List of Song
    When Click Song Title
    Then The Song Will Play

Pause the Song
    Given Song is Playing
    When Click Pause button
    Then The Song Pause

Play Next Song
    Given The Song Pause
    When Click Next button
    Then The Next Song Will Play

Play Previous Song
    Given The Next Song is Playing
    When Click Previous button twice
    Then The Previous Song Will Play