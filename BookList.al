page 50102 "LAB Book List"
{
    PageType = List;
    CardPageId = "LAB Book Card";
    SourceTable = "LAB Book";
    Editable = false;
    Caption = 'Book List';

    layout
    {
        area(content)
        {
            repeater(Books)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
                field(Author; Author)
                {
                    ApplicationArea = All;
                }
                field(Hardcover;"Hard Cover")
                {
                    ApplicationArea = All;
                }
                field("Page Count"; "Page Count")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}