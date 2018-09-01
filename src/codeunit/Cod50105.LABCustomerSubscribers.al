codeunit 50105 "LAB Customer Subscribers"
{        
    /*
    //[EventSubscriber(ObjectType::Table, Database::Customer, 'OnInsert', '', false, false)]     
    local procedure CustomerOnInsert(var Customer_p : Record Customer);    

    var 
    LABBook_l : Record "Lab Book"; 
    begin        
      if LABBook_l.FindFirst() then begin
          Customer_p.validate("LAB Favourite Book No.",LABBook_l."No.");          
      end;        
    end;    
    */
}