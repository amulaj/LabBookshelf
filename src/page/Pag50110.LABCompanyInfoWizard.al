page 50110 "LAB Company Info Wizard"
{
    Caption = 'Company Information Wizard'; 
    PageType = NavigatePage;
    SourceTable = "Company Information";

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {                
                Caption = ''; 
                Editable = false; 

                field(MediaResourcesStandard;MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All; 
                    Editable = false; 
                    ShowCaption = false; 
                    Visible = TopBannerVisible and (CurrentStep < 3); 
                }
            }
            group(FinishBanner)
            {                
                Caption = ''; 
                Editable = false; 

                field(MediaResourcesDone;MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All; 
                    Editable = false; 
                    ShowCaption = false; 
                    Visible = TopBannerVisible and (CurrentStep = 3); 
                }
            }
            group(Step1)
            {
                Visible = CurrentStep = 1; 
                group(CompanyName)
                {
                    Caption = 'Company Name'; 
                    InstructionalText = 'Provide the name of your company'; 
                    field(Name;Name)
                    {
                        ApplicationArea = All; 
                    }
                }
            }
            group(Step2)
            {
                Visible = CurrentStep =  2; 
                group(EmailAddress)
                {
                    Caption = 'Email Address'; 
                    InstructionalText = 'Provide the E-mail of your company';
                    field("E-Mail";"E-Mail")                
                    {
                        ApplicationArea = All; 
                        trigger OnValidate()
                        begin
                            testfield("E-Mail"); 
                        end;
                    }
                }
            }
            group(Step3)
            {
                Visible = CurrentStep = 3; 
                group(AllDone)
                {
                    Caption = 'All Done';
                    InstructionalText = 'Thank you! All information is now ready.';
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = Basic;
                Caption = 'Back'; 
                Enabled = ActionBackAllowed; 
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    TakeStep(-1); 
                end;  
            }
            action(ActionNext)
            {
                ApplicationArea = Basic;
                Caption = 'Next'; 
                Enabled = ActionNextAllowed; 
                Image = NextRecord;
                InFooterBar = true; 

                trigger OnAction()
                begin 
                    TakeStep(1);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = Basic;
                Caption = 'Finish'; 
                Enabled = ActionFinishAllowed; 
                Image = Approve;
                InFooterBar = true; 

                trigger OnAction() 
                begin
                    CurrPage.Close(); 
                end;
            }
        }
    }

    local procedure SetControls()
    begin
        ActionBackAllowed := CurrentStep > 1;
        ActionNextAllowed := CurrentStep < 3;
        ActionFinishAllowed := CurrentStep = 3;
    end;

    local procedure TakeStep(Step: Integer)
    begin
        CurrentStep += Step; 
        SetControls();
    end;

    local procedure LoadTopBanners()
    begin 
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType()))
        and 
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png',Format(CurrentClientType()))
        then 
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and 
            MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref") then 
              TopBannerVisible := MediaResourcesDone."Media Reference".HasValue(); 
    end;

    trigger OnInit()
    begin
        LoadTopBanners(); 
    end;

    trigger OnOpenPage()
    begin
        CurrentStep := 1;
        SetControls();
    end;
    
    var
        CurrentStep: Integer;
        ActionBackAllowed: Boolean;
        ActionNextAllowed: Boolean; 
        ActionFinishAllowed: Boolean; 
        MediaRepositoryStandard: Record "Media Repository"; 
        MediaRepositoryDone: Record "Media Repository"; 
        MediaResourcesStandard: Record "Media Resources"; 
        MediaResourcesDone: Record "Media Resources"; 
        TopBannerVisible: Boolean; 
}