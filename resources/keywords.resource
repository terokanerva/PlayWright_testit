*** Settings ***
Library    Browser

*** Keywords ***
Open Playwright Site
    New Browser    chromium    headless=${False}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    url=https://playwright.dev/

Normalize Text
    [Arguments]    ${text}
    # Poistaa yleisimmät näkymättömät ja typografiset merkit:
    # - zero width space (U+200B)
    # - zero width non-joiner (U+200C)
    # - zero width joiner (U+200D)
    # - BOM (U+FEFF)
    # - non-breaking space (U+00A0)
    ${normalized}=    Evaluate
    ...    __import__('re').sub(r'[\u200B\u200C\u200D\uFEFF\u00A0]', '', '''${text}''').strip()
    RETURN    ${normalized}

Go To The Page And Verify Header
    [Arguments]    ${url}    ${expected_header}
    Go To    ${url}
    Wait For Load State    load    timeout=10000
    ${actual_header}=    Get Text    h1
    ${actual_header}=    Normalize Text    ${actual_header}
    Should Be Equal As Strings    ${actual_header}    ${expected_header}

Verify Navbar Dropdown Items
    Hover    css=.navbar__item.dropdown.dropdown--hoverable
    Wait For Elements State    css=.dropdown__menu    visible    5s

    Wait For Elements State    role=link[name="Node.js"]    visible    5s
    Wait For Elements State    role=link[name="Python"]    visible    5s
    Wait For Elements State    role=link[name="Java"]    visible    5s
    Wait For Elements State    role=link[name=".NET"]    visible    5s