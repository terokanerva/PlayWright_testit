*** Settings ***
Resource    ../resources/keywords.resource
Suite Setup    Open Playwright Site
Suite Teardown    Close Browser

Test Setup    Go To    url=https://playwright.dev/

*** Test Cases ***
Verify Playwright Site Loads
    Wait For Elements State    h1    visible    5s
    Get Text    h1    contains    Playwright enables reliable end-to-end testing
    Take Screenshot

User Clicks Get Started And Page Installation Is Shown
    Click   role=link[name="Get started"]
    ${url}=    Get Url
    Should Contain    ${url}    /docs/intro

    Wait For Elements State    css=h2#installing-playwright    visible    5s
    ${h2}=    Get Text    css=h2#installing-playwright
    ${h2}=    Normalize Text    ${h2}
    Should Be Equal    ${h2}    Installing Playwright
    Take Screenshot

Verify Dropdown Is Hidden By Default
    Wait For Elements State    css=.dropdown__menu    hidden    5s

Verify Dropdown Node.js And Its Content
    Verify Navbar Dropdown Items

User Opens Tab Community And Verifies Content
    Go To The Page And Verify Header    https://playwright.dev/community/welcome    Welcome
    Take Screenshot
