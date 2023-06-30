/*
BLOB - íåñòðóêò äâîè÷ ä-å               õðàí â ÁÄ (âíóò)
CLOB - ñèìâîëüíûå ä-å                   õðàí â ÁÄ (âíóò)
BILE - âíåø ôàéëû ÎÑ, ñîä. äâîè÷ ä-å    âíå ÁÄ (âíåø)
LOB ñîñò èç ëîêàòîðà (âíóò óê íà çíà÷) + çíà÷åíèå (ðåàëüíîå ñîäåðæèìîå)
*/

-- созд отд папку для WORD (PDF)
create directory bfile_dir as 'D:\pict\';
-- äîá â òàáë FOTO BLOB, DOC BFILE
create table BigFiles (
    username varchar2(50) not null,
    foto blob not null,
    doc bfile
    );
-- äîá ôîòêè è äîêè â òàáëèöó
insert into BigFiles
    values ('Julia',
            utl_raw.cast_to_raw('D:\pict\mysh.png'),
            BFILENAME( 'bfile_dir', 'db.docx'));
select * from BigFiles;