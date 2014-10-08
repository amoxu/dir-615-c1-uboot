#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
	Mar/26/2009, ver 1.00 build 0001, EricKuo
	1. remove space, tab in the .html, .htm, .asp, .js, .xml
	2.
*/

#define VERSION_STR  "v1.00.01"
#define VERSION_DATE "Mar/26/2009"

#define MAX_FILE_SIZE       (1024*1024)
static char FileBuf[MAX_FILE_SIZE];
static char FileBuf_2[MAX_FILE_SIZE];

static char *process_ext[] = { "html", "htm", "asp", "js", "xml" };
static int need_process(char *filename)
{
    unsigned char *ext;
    int i;

    ext = strrchr(filename, '.');
    if (ext)
        ext++;
    else
    {
        printf("filename = %s, no .ext\n", filename);
        return 0;
    }

    //printf("filename = %s, ext=%s\n", filename, ext);
    
    for (i=0; i<sizeof(process_ext)/sizeof(char*); i++)
    {
        if (strcmp(ext, process_ext[i]) == 0)
        {
            //printf("filename = %s, matched ext =%s\n", filename, ext);
            return 1;
        }
    }
    
    //printf("filename = %s, no matched .ext\n", filename);
    return 0;
}

#define LIST_FILE   "tmp_list.txt"
int main(int argc, char *argv[])
{
	/*
		Date:	2010-05-13
		Name:	Jimmy Huang
		Reason:	Fixed the Segmentation fault bug
				cp ../../www/TEW-652BRP/www/but_advancedsetting_0.gif /home/AthSDK/rootfs/target/www/but_advancedsetting_0.gif
				total length = 110, cause Segmentation fault ..
		Notice :
				cmd_buf needs length = "argv[1] + s + new_filename"
				s ==> 100
				new_filename ==> 200
				argv[1] ==> you can get the limitation for argument length, in command shell, use "getconf ARG_MAX"
				So...it still has some flaw for cmd_buf...if argv[1] is too long
	*/
    //unsigned char cmd_buf[100];
    unsigned char cmd_buf[300];
    FILE *flist, *fout, *fin;
    unsigned char s[100];
    int n, i, j;
    unsigned char new_filename[200];
    unsigned long file_size;
    //unsigned char
    unsigned char full_src_name[100];
    int skip_flag;

    if (argc != 3)
    {
        printf("usage: %s [src_directory] [dest_directory]\n", argv[0]);
        goto fail;
    }

	printf("cp_html version %s, date %s, src_directory=%s, dest_directory=%s\n", VERSION_STR, VERSION_DATE, argv[1], argv[2]);

    sprintf(cmd_buf, "rm -f %s", LIST_FILE);
    system(cmd_buf);
    
    sprintf(cmd_buf, "ls %s > %s", argv[1], LIST_FILE);
    system(cmd_buf);
    
    sprintf(cmd_buf, "rm -rf %s/* ", argv[2]);
    system(cmd_buf);
    

    if ((flist = fopen(LIST_FILE, "r")) == NULL)
    {
        printf("Error: Can not open list file \"%s\".\n", LIST_FILE);
        goto fail;
    }

    for(;;)
    {
        if (fgets(s, sizeof(s), flist) == NULL)
            break;

        // remove the endding '\n'
        n = strlen(s);
        if (n && s[n-1]=='\n')
            s[n-1] = '\0';

        new_filename[0] = 0;
        strcpy(new_filename, argv[2]);
        strcat(new_filename, "/");
        strcat(new_filename, s);

        sprintf(full_src_name, "%s/%s", argv[1], s);

        if (need_process(s))
        {
            if ((fin  = fopen(full_src_name, "rb")) == NULL)
            {
                printf("Error: Can not open input file \"%s\".", full_src_name);
                goto fail;
            }
            fseek(fin, 0, SEEK_END);
            file_size = ftell(fin);
            fseek(fin, 0, SEEK_SET);
            fread(FileBuf, 1, file_size, fin);
            fclose(fin);

            if ((fout = fopen(new_filename, "wb")) == NULL)
            {
                printf("Error: Can not open output file \"%s\".", new_filename);
                goto fail;
            }

            for(i=0; i<file_size; i++)
            {
                if (FileBuf[i] == 0x0d || FileBuf[i] == 0x0a ||
                    FileBuf[i] == ' '  || FileBuf[i] == 0x09)
                {
                    continue;
                }
                break;
            }

            file_size -= i;

            j = 0;
            skip_flag = 0;
            for (i=0; i<file_size; i++)
            {
                if (FileBuf[i] == 0x0d)
                    continue;
				/*  Date    : 2010-05-11
				*   Name    : Jimmy Huang
				*   Reason  : Remove "Byte Order Mark" within html pages, that may cause WEB GUI shows weird character
				*   Note    :
				*			Reference
				*			http://zh.wikipedia.org/zh-tw/%E4%BD%8D%E5%85%83%E7%B5%84%E9%A0%86%E5%BA%8F%E8%A8%98%E8%99%9F
				*			http://en.wikipedia.org/wiki/Byte_order_mark
				*/
				if ( (((unsigned char *)(&FileBuf))[i] == 0xef) && (((unsigned char *)(&FileBuf))[i+1] == 0xbb)
					 && (((unsigned char *)(&FileBuf))[i+2] == 0xbf) )
				{
					printf("Removing UTF-8 Byte Order Mark [%x %x %x] within %s !!\n"
						,((unsigned char *)(&FileBuf))[i],((unsigned char *)(&FileBuf))[i+1]
						,((unsigned char *)(&FileBuf))[i+2],full_src_name);
					i = i + 2;
					continue;
				}else if ( (((unsigned char *)(&FileBuf))[i] == 0xfe) && (((unsigned char *)(&FileBuf))[i+1] == 0xff) )
				{
					printf("UTF-16(BE) Byte Order Mark [%x %x] within %s !!\n"
						,((unsigned char *)(&FileBuf))[i],((unsigned char *)(&FileBuf))[i+1]
						,full_src_name);
					i = i + 1;
					continue;
				}else if ( (((unsigned char *)(&FileBuf))[i] == 0xff) && (((unsigned char *)(&FileBuf))[i+1] == 0xfe) )
				{
					printf("UTF-16(LE) Byte Order Mark [%x %x] within %s !! \n"
						,((unsigned char *)(&FileBuf))[i],((unsigned char *)(&FileBuf))[i+1]
						,full_src_name);
					i = i + 1;
					continue;
				}

    			if (skip_flag == 0 && FileBuf[i] == '<' && FileBuf[i+1] == '!')
    			{
    			    skip_flag = 1;
    			    goto _skip;
    			}

                if (i>0)
                {
				    if (FileBuf[i] == ' ' || FileBuf[i] == 0x09)
				    {
				        if (j>=1)
					    if (FileBuf_2[j-1] == ' ' || FileBuf_2[j-1] == 0x09)
						    continue;
				    }
    				if ( FileBuf[i] == 0x0a || FileBuf[i] == ' '  || FileBuf[i] == 0x09)
    				{
    				    if (j>=1)
    					if (FileBuf_2[j-1] == 0x0a)
    					{
    						skip_flag = 0;
    						continue;
    					}
    				}

    				if (skip_flag == 1)
    				{
    					if (j >= 2)
    				    if (FileBuf[j-2] == '-' && FileBuf[j-1] == '-' && FileBuf[j] == '>')
    				    {
							skip_flag = 0;
						}

						goto _skip;
    				}

    				if (FileBuf[i] == '/' && FileBuf[i+1] == '/' && FileBuf[i-1] != ':' && FileBuf[i-1] != '0')
    				{
    				    for(;;)
    				    {
    				        if (FileBuf[i] != 0x0a && i<file_size)
    				        {
    				            i++;
    				        }
    				        else
    				            break;
    				    }
    				}
                }

_skip:
                FileBuf_2[j] = FileBuf[i];
                j++;
            }

            fwrite(FileBuf_2, 1, j, fout);
            fclose(fout);
        }
        else
        {
            /*NickChou add -rf
            cp file and directory (not include CVS)
            */
            sprintf(cmd_buf, "cp -rf %s/%s %s", argv[1], s, new_filename);
            system(cmd_buf);
        }

    }

    close (fin);
    close (fout);
    close (flist);
    
    sprintf(cmd_buf, "rm %s", LIST_FILE);
    system(cmd_buf);
    
    sprintf(cmd_buf, "cd %s ; find -name CVS -exec rm -rf {} ';'", argv[2]);
    system(cmd_buf);
    
    return 0;

fail:
    close (fin);
    close (fout);
    close (flist);
    sprintf(cmd_buf, "rm %s", LIST_FILE);
    system(cmd_buf);
    return -1;
}
