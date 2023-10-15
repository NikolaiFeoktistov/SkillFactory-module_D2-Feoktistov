user1 = User.objects.create(username='Mike', first_name='Frank')
user2= User.objects.create(username='Ben', first_name='Ten')

Author.objects.create(user=user1)
Author.objects.create(user=user2)

Category.objects.create(name='IT')
Category.objects.create(name='Education')
Category.objects.create(name='Math')
Category.objects.create(name='Sport')

Post.objects.create(author=Author.objects.get(user=User.objects.get(username='Mike')), post_type='article', title = 'other text', content = 'other text')
Post.objects.create(author=Author.objects.get(user=User.objects.get(username='Ben')), post_type='article', title = 'other text098', content = 'other text098')
Post.objects.create(author=Author.objects.get(user=User.objects.get(username='Mike')), post_type='news', title = 'other text123', content = 'other text123')
Post.objects.create(author=Author.objects.get(user=User.objects.get(username='Ben')), post_type='news', title = 'other text567', content = 'other text567')

p1 = Post.objects.get(pk=1)
p2 = Post.objects.get(pk=2)
p3 = Post.objects.get(pk=3)
p4 = Post.objects.get(pk=4)
c1 = Category.objects.get(name='IT')
c2 = Category.objects.get(name='Education')
c3 = Category.objects.get(name='Math')
c4 = Category.objects.get(name='Sport')
p1.categories.add(c1, c2)
p2.categories.add(c1, c2, c3)
p3.categories.add(c2, c4)
p4.categories.add(c3, c4)

Comment.objects.create(user=User.objects.get(username='Mike'), post=Post.objects.get(pk=1), text='comment text1')
Comment.objects.create(user=User.objects.get(username='Mike'), post=Post.objects.get(pk=2), text='comment text1')
Comment.objects.create(user=User.objects.get(username='Ben'), post=Post.objects.get(pk=3), text='comment123 text1')
Comment.objects.create(user=User.objects.get(username='Ben'), post=Post.objects.get(pk=4), text='comment123 text1')

Post.objects.get(pk=1).like()
Post.objects.get(pk=1).dislike()
Post.objects.get(pk=2).like()
Post.objects.get(pk=2).dislike()
Post.objects.get(pk=3).like()
Post.objects.get(pk=3).dislike()
Post.objects.get(pk=4).like()
Post.objects.get(pk=4).dislike()

Author.objects.get(user = User.objects.get(username='Mike')).update_rating()
Author.objects.get(user = User.objects.get(username='Ben')).update_rating()

best = Author.objects.all().order_by('-rating').values('user','rating')[0]
print(best)

best_post = Post.objects.filter(post_type='article').order_by('-rating').first()
print(f'Дата добавления: {best_post.created_at}')
print(f'Автор: {best_post.author.user.username}')
print(f'Рейтинг: {best_post.rating}')
print(f'Заголовок: {best_post.title}')
print(f'Превью: {best_post.preview()}')

comments_to_best_post = Comment.objects.filter(post=best_post)
for comment in comments_to_best_post:
print(f'Дата: {comment.created_at}, Пользователь: {comment.user.username}, Рейтинг: {comment.rating}, Текст: {comment.text}')
