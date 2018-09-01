table 50100 "Lab Book"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"No.";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Title;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Author;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Hard Cover";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Page Count";Integer)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Obsolete; 
            ObsoleteReason = 'Page Count Field wird nicht mehr benötigt und wir daher als Obsolet markiert.';
        }
    }

    keys
    {
        key(PK;"No.")
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown;"No.","Title")
        {
            
        }
    }
    var
        myInt : Integer;

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

}