Vim�UnDo� ��g���B'���f3 �]��O�X�+�3�1      1                                       password=)      0                       `�ߐ    _�                             ����                                                                                                                                                                                                                                                                                                                                       M           V        `��2     �              M   !# from jobs import JobBoard, URLS   import discord   'from discord.ext import commands, tasks   # from datetime import datetime   # import csv   # import discord       ETOKEN = 'NzcxNDgzNDgxMTMzOTQwNzU3.X5sx-w.wF73XI5njt4A90g5qwYdb4Z27tg'   /# TODAY = datetime.today().strftime('%Y-%m-%d')       description = """    This is a test.   """       %# intents = discord.Intents.default()   # intents.members = True       &bot = commands.Bot(command_prefix="!",   +                   description=description)       
@bot.event   async def on_ready():       print('Logged in as')       print(bot.user.name)       print(bot.user.id)       print('------')           # @bot.command()   # async def jobs(ctx):   #   #     n = 0   -#     if ctx.author.id != 188496034287058944:   L#         await ctx.author.send('Message the owner to set this up for you.')   #         return None   #   #     for url in URLS:   $#         # TODO: Clean this code up   ,#         if (job := JobBoard(url).parse()):   #             n += 1   5#             title, company, location, _, link = job   $#             await ctx.author.send(   i#                 f" {n}: Position: {title}\n Company: {company}\n Location: {location}\n Link: {link}\n"   #             )   #   #     if n == 0:   D#         await ctx.author.send('There were no new postings today.')   #   # @bot.command()   # async def apply(ctx, arg):   3#     # TODO: !applied {n}, opens and writes to csv   #   -#     if ctx.author.id == 188496034287058944:   0#         # TODO: have this connected to MongoDB   $#         # TODO: Clean this code up   -#         with open('applied.csv', 'a') as f:   5#             writer = csv.writer(f, delimiter = ',')   #             n = 0   #             for url in URLS:   4#                 if (job := JobBoard(url).parse()):   #                     n += 1   '#                     if n == int(arg):   .#                         writer.writerow(job)   ?#                         await ctx.author.send('Entry added.')   #                         break   #   #     else:   L#         await ctx.author.send('Message the owner to set this up for you.')           @bot.command()   *async def add(ctx, left: int, right: int):   $    """Adds two numbers together."""        await ctx.send(left + right)           bot.run(TOKEN)5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        `��4     �                   5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        `��L     �                 �              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        `��`     �                  �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        `��y     �                 """5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        `��{     �                     """5�_�      	                 
    ����                                                                                                                                                                                                                                                                                                                                                  V        `���     �                   expect Error as e:5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                  V        `���     �                            print(e)5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                  V        `��     �                             conn.close()5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                  V        `��     �               /           print('Connected to MySQL database')5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        `��     �                          print(e)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        `��(     �                             �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        `��+     �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        `��/     �                                 �                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        `��5     �                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        `��D     �                           5�_�                    
   ,    ����                                                                                                                                                                                                                                                                                                                                                  V        `��[     �   	            -        conn = mysql.connector.connect(host=,5�_�                       0    ����                                                                                                                                                                                                                                                                                                                                                  V        `�߉     �   
            1                                       database=,5�_�                       ,    ����                                                                                                                                                                                                                                                                                                                                                  V        `�ߌ     �               -                                       user=,5�_�                        0    ����                                                                                                                                                                                                                                                                                                                                                  V        `�ߏ    �               1                                       password=)5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        `��H     �                �                5��