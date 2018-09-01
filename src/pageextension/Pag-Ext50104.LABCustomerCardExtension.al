pageextension 50104 "LAB Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("LAB Favourite Book No.";"LAB Favourite Book No.")
            {
                ApplicationArea = All;
            }
            field("LAB Favourite Book Title"; "LAB Favourite Book Title")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(NewServiceQuote)
        {
            action(WebServiceCall)
            {    
                Image = Web;             
                trigger OnAction();
                begin
                    WebServiceCallCodeunit.Run(); 
                end;
            }
        }
    }
    var
        WebServiceCallCodeunit: Codeunit WebServiceCall; 
}