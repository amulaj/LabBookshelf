page 50101 "LAB Book Card"
{
    PageType = Card;
    SourceTable = "LAB Book";
    Caption = 'Book Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(Author; Author)
                {
                    ApplicationArea = All;
                }
                field(Hardcover; "Hard Cover")
                {
                    ApplicationArea = All;
                }
                /*
                field("Page Count"; "Page Count")
                {
                    ApplicationArea = All;
                }
                */
            }
        }
    }
}