# eye-tyrant
D&amp;D DM Framework for Electronic table display

This project is to help facilitate the DM process
while using an electronic table (A table with a TV in it).

The goal is to have an Initiative sorter for Players and NPCs,
Searchable Bestiary, and a Searchable Spell list.
The players will have the ability to provide a character portrait.
This portrait will be displayed when it is their initiative.

*Notes on the ideas of what each class should accomplish*

Participant Class
*what should both a character and a monster be able to do*
Create()
    - make new participant, link to given encounter or newest encounter
TakeDamage()
    - add damage up to hitpoints
    - set “inactive” if damage = hitpoints
HealDamage()
    - remove damage, up to a maximum of 0 damage
    - set active if damage != hitpoints 
SetInitiative()
    - set the initiative of the character for combat
ResetInitiative (may have this a class method)
    - sets initiative to 0 for all active participants.
    - this will mostly be used for characters.

Monster Class < Participant
    *inherits from participant*
Create()
    - inherits the participant_id from the participant table.
    - sets the name based on the monster_type (maybe the SetName() method?)
SetName()
    - Sets the monster’s name based on the MonsterType and the number of this type in this encounter
    - this may be slightly weird, need to figure out how to do it.
GetMonsterDetails()
    - gets the monster information from the monster_type

Character < Participant
    *inherits from participant*
Create()
    - inherits the participant_id from the participant table.
