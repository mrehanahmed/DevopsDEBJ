trigger AccountTrigger on Account (before insert, before update, After insert)
{
            AccountTriggerHandler handler = new AccountTriggerHandler();

    if (trigger.isInsert){
        if(trigger.isBefore){
            handler.BeforeInsert(Trigger.new);
        }
    }
    if (Trigger.isAfter) {
        handler.AfterInsert(Trigger.new);
        }
        
}
