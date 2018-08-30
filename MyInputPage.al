page 50130 MyInputPage

{
    PageType = StandardDialog;
    //SourceTable = TableName;

    layout

    {
        area(content)
        {
            group(Input)

            {
                field(myText;myText)
                {
                    ApplicationArea = all;                    
                    Caption = 'Geben Sie bitte einen Domain Namen ein zum Beispiel (google.com)';
                }
            }
        }
    }



    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin

                end;
            }
        }
    }

    

    var
        myText : Text;                       

    procedure SetInput(NewValue : Text);
    begin
        myText := NewValue;
    end;

    procedure GetInput():text;
    begin
        exit(myText);
    end;

}