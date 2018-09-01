tableextension 50103 "LAB Customer Extension" extends Customer
{
    fields
    {
        field(50100; "LAB Favourite Book No."; Code[20])
        {
            Caption = 'Favourite Book Id';
            TableRelation = "LAB Book";

            trigger OnValidate()
            var
                Book: Record "LAB Book";
            begin
                Book.SetRange("No.", "LAB Favourite Book No.");
                Book.FindFirst();
                "LAB Favourite Book Title" := Book.Title;
            end;

        }
        field(50101; "LAB Favourite Book Title"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("LAB Book".Title where ("No." = field ("LAB Favourite Book No.")));
            Caption = 'Favourite Book Title';
            Editable = false;
        }
    }
}