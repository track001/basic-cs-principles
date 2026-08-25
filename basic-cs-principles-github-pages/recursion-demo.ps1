Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ============================================================
# RECURSION DEMO
#
# Basic computer science principle:
#
# Recursion is when a function calls itself.
#
# The function keeps getting a smaller version of the same
# problem until it reaches a stopping point.
#
# That stopping point is the base case.
#
# This demo uses factorials because they make recursion easy
# to see without needing much math.
#
# 5! = 5 * 4 * 3 * 2 * 1
#
# We can write the exact same thing recursively:
#
# factorial(5) = 5 * factorial(4)
# factorial(4) = 4 * factorial(3)
# factorial(3) = 3 * factorial(2)
# factorial(2) = 2 * factorial(1)
#
# factorial(1) is the base case.
# ============================================================


# ============================================================
# COLORS
#
# I like green and I do not like the normal Windows aesthetic,
# so black / dark green / plants.
# ============================================================

$BackgroundColor = [System.Drawing.Color]::FromArgb(7, 12, 9)
$PanelColor      = [System.Drawing.Color]::FromArgb(13, 29, 20)
$InputColor      = [System.Drawing.Color]::FromArgb(10, 20, 14)

$DarkGreen       = [System.Drawing.Color]::FromArgb(24, 82, 49)
$Green           = [System.Drawing.Color]::FromArgb(65, 145, 90)
$LightGreen      = [System.Drawing.Color]::FromArgb(170, 225, 175)

$TextColor       = [System.Drawing.Color]::FromArgb(235, 241, 236)
$MutedText       = [System.Drawing.Color]::FromArgb(155, 185, 163)


# ============================================================
# RECURSIVE FACTORIAL FUNCTION
#
# This is the actual recursion.
# ============================================================

function Get-Factorial {

    param(
        [int64]$Number
    )


    # --------------------------------------------------------
    # BASE CASE
    #
    # The function needs somewhere to stop.
    #
    # Once Number reaches 1 or 0, we already know the answer
    # is 1, so there is no reason to call the function again.
    # --------------------------------------------------------

    if ($Number -le 1) {
        return [int64]1
    }


    # --------------------------------------------------------
    # RECURSIVE CASE
    #
    # This is the line where the function calls itself.
    #
    # If Number is 5:
    #
    # 5 * Get-Factorial(4)
    #
    # Get-Factorial(4) then does:
    #
    # 4 * Get-Factorial(3)
    #
    # It keeps shrinking the problem until it reaches the
    # base case above.
    # --------------------------------------------------------

    return $Number * (Get-Factorial ($Number - 1))
}


# ============================================================
# RECURSION TRACE
#
# PowerShell does not normally show every recursive call.
#
# I want to actually see what is happening, so this makes
# a readable version for the GUI.
# ============================================================

function Get-RecursionTrace {

    param(
        [int]$Number
    )

    $lines = New-Object System.Collections.Generic.List[string]


    # Start by showing the calls going DOWN toward the base case.
    $lines.Add("GOING DOWN THROUGH THE FUNCTION CALLS")
    $lines.Add("--------------------------------------")
    $lines.Add("")


    # If we start at zero, we are already at the base case.
    if ($Number -eq 0) {

        $lines.Add("factorial(0)")
        $lines.Add("    -> BASE CASE")
        $lines.Add("    -> return 1")

        $lines.Add("")
        $lines.Add("We started at the base case, so there was no recursive call.")

        return ($lines -join "`r`n")
    }


    # Show each recursive call.
    for ($i = $Number; $i -ge 1; $i--) {

        if ($i -eq 1) {

            $lines.Add("factorial(1)")
            $lines.Add("    -> BASE CASE")
            $lines.Add("    -> return 1")
        }
        else {

            $lines.Add(
                "factorial($i) -> $i * factorial($($i - 1))"
            )
        }
    }


    $lines.Add("")
    $lines.Add("BASE CASE REACHED")
    $lines.Add("")


    # Now show the values returning back UP.
    $lines.Add("COMING BACK UP")
    $lines.Add("--------------------------------------")
    $lines.Add("")


    $running = 1


    for ($i = 2; $i -le $Number; $i++) {

        $previous = $running
        $running = $i * $running

        $lines.Add("$i * $previous = $running")
    }


    if ($Number -eq 1) {

        $lines.Add("The starting number was already the base case.")
        $lines.Add("Final answer = 1")
    }


    return ($lines -join "`r`n")
}


# ============================================================
# MAIN WINDOW
#
# The old version used fixed coordinates for basically
# everything.
#
# Windows display scaling made the text bigger while the boxes
# stayed the same size, which is why stuff kept getting cut off.
#
# This one uses layout panels instead.
# ============================================================

$form = New-Object System.Windows.Forms.Form

$form.Text = "Recursion // Basic CS Demo"

$form.BackColor = $BackgroundColor
$form.ForeColor = $TextColor

# Start at a decent size, but actually let the window resize.
$form.ClientSize = New-Object System.Drawing.Size(1000, 820)

# Do not let it get so small that the layout becomes useless.
$form.MinimumSize = New-Object System.Drawing.Size(800, 650)

$form.StartPosition = "CenterScreen"

# IMPORTANT:
# Sizable instead of FixedSingle.
# This means I can actually drag the edges of the window.
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Sizable

$form.MaximizeBox = $true

# Let Windows account for DPI rather than fighting the layout.
$form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi


# ============================================================
# MAIN LAYOUT
#
# Everything goes into this instead of manually guessing
# X/Y coordinates for every single control.
#
# Dock = Fill means it follows the window when I resize it.
# ============================================================

$mainLayout = New-Object System.Windows.Forms.TableLayoutPanel

$mainLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

$mainLayout.BackColor = $BackgroundColor

$mainLayout.Padding = New-Object System.Windows.Forms.Padding(
    30,
    20,
    30,
    20
)

$mainLayout.ColumnCount = 1
$mainLayout.RowCount = 6

# Title
$mainLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::AutoSize
    ))
)

# Explanation
$mainLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::Absolute,
        190
    ))
)

# Input / button
$mainLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::AutoSize
    ))
)

# Result
$mainLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::AutoSize
    ))
)

# Trace box gets whatever space is left.
$mainLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::Percent,
        100
    ))
)

# Footer
$mainLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::AutoSize
    ))
)

$form.Controls.Add($mainLayout)


# ============================================================
# TITLE ROW
# ============================================================

$titlePanel = New-Object System.Windows.Forms.Panel

$titlePanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$titlePanel.Height = 85
$titlePanel.BackColor = $BackgroundColor


$title = New-Object System.Windows.Forms.Label

$title.Text = "RECURSION"

$title.AutoSize = $true

$title.Location = New-Object System.Drawing.Point(5, 10)

$title.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    26,
    [System.Drawing.FontStyle]::Bold
)

$title.ForeColor = $LightGreen

$titlePanel.Controls.Add($title)


# Small plant decoration.
$plantLabel = New-Object System.Windows.Forms.Label

$plantLabel.Text =
"     .     /`r`n" +
"      \   /`r`n" +
"       \ /`r`n" +
"        |`r`n" +
"      --|--"

$plantLabel.AutoSize = $true

$plantLabel.Anchor =
    [System.Windows.Forms.AnchorStyles]::Top -bor
    [System.Windows.Forms.AnchorStyles]::Right

$plantLabel.Location = New-Object System.Drawing.Point(825, 3)

$plantLabel.Font = New-Object System.Drawing.Font(
    "Consolas",
    10
)

$plantLabel.ForeColor = $Green

$titlePanel.Controls.Add($plantLabel)


# Keep the plant on the right if the window changes size.
$titlePanel.Add_Resize({

    $plantLabel.Left =
        $titlePanel.ClientSize.Width -
        $plantLabel.Width -
        20
})


$mainLayout.Controls.Add($titlePanel, 0, 0)


# ============================================================
# EXPLANATION PANEL
#
# Using a RichTextBox instead of a Label.
#
# Main reason: it wraps correctly and can scroll if someone's
# Windows text scaling is huge.
# ============================================================

$infoPanel = New-Object System.Windows.Forms.Panel

$infoPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$infoPanel.BackColor = $PanelColor

$infoPanel.Padding = New-Object System.Windows.Forms.Padding(
    18,
    12,
    18,
    12
)


$infoLayout = New-Object System.Windows.Forms.TableLayoutPanel

$infoLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

$infoLayout.ColumnCount = 1
$infoLayout.RowCount = 2

$infoLayout.BackColor = $PanelColor

$infoLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::AutoSize
    ))
)

$infoLayout.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::Percent,
        100
    ))
)


$infoTitle = New-Object System.Windows.Forms.Label

$infoTitle.Text = "What are we demonstrating?"

$infoTitle.AutoSize = $true

$infoTitle.Margin = New-Object System.Windows.Forms.Padding(
    0,
    0,
    0,
    8
)

$infoTitle.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    12,
    [System.Drawing.FontStyle]::Bold
)

$infoTitle.ForeColor = $LightGreen


$infoText = New-Object System.Windows.Forms.RichTextBox

$infoText.Dock = [System.Windows.Forms.DockStyle]::Fill

$infoText.ReadOnly = $true

$infoText.BorderStyle =
    [System.Windows.Forms.BorderStyle]::None

$infoText.BackColor = $PanelColor
$infoText.ForeColor = $TextColor

$infoText.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    10
)

$infoText.ScrollBars =
    [System.Windows.Forms.RichTextBoxScrollBars]::Vertical

$infoText.Text =
"Recursion is when a function solves a problem by calling itself with a smaller version of that same problem.`r`n`r`n" +
"The base case is the condition that stops those calls. Without a base case, the function would keep calling itself until the program eventually fails.`r`n`r`n" +
"This demo uses factorials because the problem naturally gets smaller. 5! = 5 x 4 x 3 x 2 x 1, so factorial(5) can also be written as 5 x factorial(4)."


$infoLayout.Controls.Add($infoTitle, 0, 0)
$infoLayout.Controls.Add($infoText, 0, 1)

$infoPanel.Controls.Add($infoLayout)

$mainLayout.Controls.Add($infoPanel, 0, 1)


# ============================================================
# INPUT ROW
#
# Using a FlowLayoutPanel here because I do not care about
# exact pixel positions. I just want these controls next to
# each other with enough room.
# ============================================================

$inputPanel = New-Object System.Windows.Forms.FlowLayoutPanel

$inputPanel.Dock = [System.Windows.Forms.DockStyle]::Fill

$inputPanel.AutoSize = $true

$inputPanel.WrapContents = $true

$inputPanel.FlowDirection =
    [System.Windows.Forms.FlowDirection]::LeftToRight

$inputPanel.BackColor = $BackgroundColor

$inputPanel.Padding = New-Object System.Windows.Forms.Padding(
    5,
    18,
    5,
    12
)


$inputLabel = New-Object System.Windows.Forms.Label

$inputLabel.Text =
    "Enter a number to watch recursion work:"

$inputLabel.AutoSize = $true

$inputLabel.Margin = New-Object System.Windows.Forms.Padding(
    0,
    7,
    15,
    0
)

$inputLabel.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    11,
    [System.Drawing.FontStyle]::Bold
)

$inputLabel.ForeColor = $TextColor


$textBox = New-Object System.Windows.Forms.TextBox

$textBox.Width = 110

$textBox.Margin = New-Object System.Windows.Forms.Padding(
    0,
    4,
    20,
    0
)

$textBox.BackColor = $InputColor
$textBox.ForeColor = $LightGreen

$textBox.BorderStyle =
    [System.Windows.Forms.BorderStyle]::FixedSingle

$textBox.Font = New-Object System.Drawing.Font(
    "Consolas",
    12
)


$button = New-Object System.Windows.Forms.Button

$button.Text = "RUN RECURSION"

$button.AutoSize = $true

$button.Padding = New-Object System.Windows.Forms.Padding(
    12,
    4,
    12,
    4
)

$button.Margin = New-Object System.Windows.Forms.Padding(
    0,
    0,
    0,
    0
)

$button.BackColor = $DarkGreen
$button.ForeColor = $TextColor

$button.FlatStyle =
    [System.Windows.Forms.FlatStyle]::Flat

$button.FlatAppearance.BorderColor = $Green
$button.FlatAppearance.BorderSize = 1

$button.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    10,
    [System.Drawing.FontStyle]::Bold
)


$inputPanel.Controls.Add($inputLabel)
$inputPanel.Controls.Add($textBox)
$inputPanel.Controls.Add($button)

$mainLayout.Controls.Add($inputPanel, 0, 2)


# ============================================================
# RESULT
# ============================================================

$resultLabel = New-Object System.Windows.Forms.Label

$resultLabel.Text = "Result will appear here."

$resultLabel.AutoSize = $true

$resultLabel.Margin = New-Object System.Windows.Forms.Padding(
    5,
    5,
    5,
    12
)

$resultLabel.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    16,
    [System.Drawing.FontStyle]::Bold
)

$resultLabel.ForeColor = $LightGreen

$mainLayout.Controls.Add($resultLabel, 0, 3)


# ============================================================
# TRACE AREA
#
# This section is allowed to grow and shrink with the window.
#
# This was one of the biggest problems with the old version.
# ============================================================

$tracePanel = New-Object System.Windows.Forms.TableLayoutPanel

$tracePanel.Dock = [System.Windows.Forms.DockStyle]::Fill

$tracePanel.ColumnCount = 1
$tracePanel.RowCount = 2

$tracePanel.BackColor = $BackgroundColor

$tracePanel.Margin = New-Object System.Windows.Forms.Padding(
    5,
    0,
    5,
    10
)

$tracePanel.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::AutoSize
    ))
)

$tracePanel.RowStyles.Add(
    (New-Object System.Windows.Forms.RowStyle(
        [System.Windows.Forms.SizeType]::Percent,
        100
    ))
)


$traceTitle = New-Object System.Windows.Forms.Label

$traceTitle.Text = "What the computer is doing:"

$traceTitle.AutoSize = $true

$traceTitle.Margin = New-Object System.Windows.Forms.Padding(
    0,
    0,
    0,
    6
)

$traceTitle.Font = New-Object System.Drawing.Font(
    "Segoe UI",
    11,
    [System.Drawing.FontStyle]::Bold
)

$traceTitle.ForeColor = $TextColor


$traceBox = New-Object System.Windows.Forms.RichTextBox

$traceBox.Dock = [System.Windows.Forms.DockStyle]::Fill

$traceBox.ReadOnly = $true

$traceBox.BackColor = $InputColor
$traceBox.ForeColor = $LightGreen

$traceBox.Font = New-Object System.Drawing.Font(
    "Consolas",
    10
)

$traceBox.BorderStyle =
    [System.Windows.Forms.BorderStyle]::FixedSingle

$traceBox.ScrollBars =
    [System.Windows.Forms.RichTextBoxScrollBars]::Vertical

$traceBox.WordWrap = $false

$traceBox.Text =
"Enter something like 5.`r`n`r`n" +
"The program will show each recursive call until it reaches the base case."


$tracePanel.Controls.Add($traceTitle, 0, 0)
$tracePanel.Controls.Add($traceBox, 0, 1)

$mainLayout.Controls.Add($tracePanel, 0, 4)


# ============================================================
# FOOTER
#
# AutoSize means the control sizes itself based on the text
# instead of chopping the bottom half off.
# ============================================================

$footer = New-Object System.Windows.Forms.Label

$footer.Text =
"remember: recursion = function calls itself  //  base case = where it stops"

$footer.AutoSize = $true

$footer.Margin = New-Object System.Windows.Forms.Padding(
    5,
    4,
    5,
    0
)

$footer.Font = New-Object System.Drawing.Font(
    "Consolas",
    10,
    [System.Drawing.FontStyle]::Italic
)

$footer.ForeColor = $MutedText

$mainLayout.Controls.Add($footer, 0, 5)


# ============================================================
# RUN BUTTON
#
# Everything below happens after RUN RECURSION is clicked.
# ============================================================

$button.Add_Click({

    $number = 0


    # --------------------------------------------------------
    # INPUT CHECK
    #
    # TryParse checks if what was typed can actually become
    # an integer.
    # --------------------------------------------------------

    if (-not [int]::TryParse(
        $textBox.Text,
        [ref]$number
    )) {

        $resultLabel.Text =
            "Enter a valid whole number."

        $traceBox.Text =
            "The recursive function did not run because the input was not a valid integer."

        return
    }


    # No negative factorials for this basic example.
    if ($number -lt 0) {

        $resultLabel.Text =
            "Use 0 or a positive number."

        $traceBox.Text =
            "For this demo, enter a whole number from 0 to 20."

        return
    }


    # Factorials get huge extremely fast.
    #
    # 20 is plenty for seeing recursion and also fits inside
    # the integer type being used here.
    if ($number -gt 20) {

        $resultLabel.Text =
            "Keep it at 20 or below."

        $traceBox.Text =
            "Factorials grow really fast. 20 is more than enough for this recursion example."

        return
    }


    # ========================================================
    # START THE RECURSION
    #
    # If I enter 5:
    #
    # Get-Factorial 5
    #
    # calls
    #
    # Get-Factorial 4
    #
    # which calls
    #
    # Get-Factorial 3
    #
    # which calls
    #
    # Get-Factorial 2
    #
    # which calls
    #
    # Get-Factorial 1
    #
    # 1 is the base case.
    #
    # Then every function call starts returning its answer
    # back to the function that called it.
    # ========================================================

    $answer = Get-Factorial $number


    # Final answer after all recursive calls have returned.
    $resultLabel.Text =
        "$number! = $answer"


    # Show the same process in a way I can actually read.
    $traceBox.Text =
        Get-RecursionTrace $number
})


# ============================================================
# ENTER KEY
#
# Not recursion.
#
# This just makes Enter do the same thing as clicking the
# RUN RECURSION button.
# ============================================================

$form.AcceptButton = $button


# ============================================================
# SHOW WINDOW
# ============================================================

[void]$form.ShowDialog()
