create directory bfile_dir3 as '/photo/lob/';

create table BigFiles (
    username varchar2(50) not null,
    foto blob not null,
    doc bfile
    );
    
insert into BigFiles
    values ('Kristine',
            BFILENAME( 'BFILE_DIR3', 'photo.jpg'),
            BFILENAME( 'BFILE_DIR3', 'text.txt'));
        
select * from BigFiles