require "import"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.content.*"
import "android.net.Uri"
import "java.io.*"
import "android.provider.MediaStore"
import "android.graphics.drawable.ColorDrawable"
import "android.graphics.Color"

local activity = activity
local fileUri, selectedFile, fileNameTextView, selectFileButton, shareButton, deleteButton, progressBar, fileTypeTextView, fileInfoTextView

function onCreate(savedInstanceState)
    activity.setTitle("File Sharing Tool")
    showMainMenu()
end

function createStatusBar(text)
    local layout = LinearLayout(activity)
    layout.setBackgroundColor(Color.parseColor("#E0E0E0"))
    layout.setPadding(20, 20, 20, 20)
    local params = LinearLayout.LayoutParams(-1, -2)
    params.setMargins(0, 10, 0, 10)
    layout.setLayoutParams(params)
    
    local tv = TextView(activity)
    tv.setText(text)
    tv.setTextSize(16)
    tv.setTextColor(Color.BLACK)
    layout.addView(tv)
    return layout
end

function showMainMenu()
    local layout = LinearLayout(activity)
    layout.setOrientation(LinearLayout.VERTICAL)
    layout.setPadding(30, 30, 30, 30)

    local btnStart = Button(activity)
    btnStart.setText("Start File Sharing")
    btnStart.setOnClickListener(function() setupFileSharingUI() end)
    layout.addView(btnStart)

    local btnAbout = Button(activity)
    btnAbout.setText("About Developer")
    btnAbout.setOnClickListener(function() showAboutUI() end)
    layout.addView(btnAbout)

    activity.setContentView(layout)
end

function showAboutUI()
    local layout = ScrollView(activity)
    local innerLayout = LinearLayout(activity)
    innerLayout.setOrientation(LinearLayout.VERTICAL)
    innerLayout.setPadding(30, 30, 30, 30)

    innerLayout.addView(createStatusBar("Developer: Mezab Ali"))
    innerLayout.addView(createStatusBar("Version: 9.1"))
    innerLayout.addView(createStatusBar("--- Itr Manual ---"))
    innerLayout.addView(createStatusBar("1. Click 'Start File Sharing' button."))
    innerLayout.addView(createStatusBar("2. Choose single or multiple files."))
    innerLayout.addView(createStatusBar("3. Use 'Share' to send selected files."))
    innerLayout.addView(createStatusBar("4. Delete button removes local reference."))

    local backBtn = Button(activity)
    backBtn.setText("Back to Menu")
    backBtn.setOnClickListener(function() showMainMenu() end)
    innerLayout.addView(backBtn)

    layout.addView(innerLayout)
    activity.setContentView(layout)
end

function setupFileSharingUI()
    local layout = LinearLayout(activity)
    layout.setOrientation(LinearLayout.VERTICAL)
    layout.setPadding(16, 16, 16, 16)

    local backBtn = Button(activity)
    backBtn.setText("Back to Menu")
    backBtn.setOnClickListener(function() showMainMenu() end)
    layout.addView(backBtn)

    local mainLayout = LinearLayout(activity)
    mainLayout.setOrientation(LinearLayout.HORIZONTAL)
    
    selectFileButton = Button(activity)
    selectFileButton.setText("Select File")
    selectFileButton.setOnClickListener(function() showFilePickerDialog() end)
    mainLayout.addView(selectFileButton)

    fileNameTextView = TextView(activity)
    fileNameTextView.setVisibility(View.GONE)
    mainLayout.addView(fileNameTextView)
    layout.addView(mainLayout)

    local buttonLayout = LinearLayout(activity)
    buttonLayout.setOrientation(LinearLayout.HORIZONTAL)
    
    shareButton = Button(activity)
    shareButton.setText("Share File")
    shareButton.setEnabled(false)
    shareButton.setOnClickListener(function() shareSelectedFile() end)
    buttonLayout.addView(shareButton)

    deleteButton = Button(activity)
    deleteButton.setText("Delete File")
    deleteButton.setEnabled(false)
    deleteButton.setVisibility(View.GONE)
    deleteButton.setOnClickListener(function() deleteSelectedFile() end)
    buttonLayout.addView(deleteButton)
    layout.addView(buttonLayout)

    fileTypeTextView = TextView(activity)
    fileTypeTextView.setVisibility(View.GONE)
    layout.addView(fileTypeTextView)

    fileInfoTextView = TextView(activity)
    fileInfoTextView.setVisibility(View.GONE)
    layout.addView(fileInfoTextView)

    progressBar = ProgressBar(activity)
    progressBar.setVisibility(View.GONE)
    layout.addView(progressBar)

    activity.setContentView(layout)
end

-- [Yahan par aapki baaki purani functions: showFilePickerDialog, onActivityResult, shareSelectedFile, deleteSelectedFile, etc. waisi hi rahengi]