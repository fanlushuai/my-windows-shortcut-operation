# pip install opencv-python
# py3.11 使用没问题
import cv2
import numpy as np
import glob, os

# 抠图去背景脚本。
# 参考：https://blog.csdn.net/my_name_is_learn/article/details/114364699
# hsv 色彩模式。https://www.cnblogs.com/lfri/p/10426113.html


def x(glob_express, bgRange, outputDir):
    print(glob_express)
    for image in glob.glob(glob_express, recursive=True):
        print("处理" + image)
        removeBackGroud(image, bgRange, outputDir)


def removeBackGroud(img, HsvRange, outputPath):
    imag_name = os.path.basename(img)  # 带后缀的文件名
    # path = os.path.dirname(img)  # 路径

    source = cv2.imread(img)
    hsv = cv2.cvtColor(source, cv2.COLOR_RGB2HSV)

    lower_BackGroudColor = np.array(HsvRange[0])
    upper_BackGroudColor = np.array(HsvRange[1])

    mask = cv2.inRange(hsv, lower_BackGroudColor, upper_BackGroudColor)

    mask_not = cv2.bitwise_not(mask)

    bg = cv2.bitwise_and(source, source, mask=mask)

    bg_not = cv2.bitwise_and(source, source, mask=mask_not)

    b, g, r = cv2.split(bg_not)

    bgra = cv2.merge([b, g, r, mask_not])

    if not os.path.exists(outputPath):
        os.makedirs(outputPath)

    cv2.imwrite(outputPath + imag_name, bgra)

    # 显示图片验证结果，opencv LOGO 图片
    # cv2.imshow("source", source)
    # cv2.imshow("bg", bg)
    # cv2.imshow("bg_not", bg_not)
    # cv2.waitKey()
    # cv2.destroyAllWindows()


from PIL import Image
import numpy as np


def remove_specific_pixels(image_path, target_color_rgb, output_path):
    # 打开图像
    img = Image.open(image_path)

    # 将图像转换为numpy数组以便进行数值操作
    img_array = np.array(img)

    # 获取目标颜色的RGB值
    target_color = np.array(target_color_rgb)

    # 遍历图像中的每个像素
    for i in range(img_array.shape[0]):
        for j in range(img_array.shape[1]):
            # 如果当前像素的颜色与目标颜色相同，则将其设置为透明（或其他你想要的颜色）
            if np.all(img_array[i, j] == target_color):
                img_array[i, j] = [0, 0, 0, 0]  # 设置为透明，最后一个0是alpha通道

    # 将修改后的numpy数组转回为PIL图像
    modified_img = Image.fromarray(img_array)

    # 保存修改后的图像
    modified_img.save(output_path)


current_directory = os.getcwd()

inputDir = current_directory + r"\images_source\\"
outputDir = current_directory + r"\images\\"

# 使用示例：移除图像中的白色像素
remove_specific_pixels(inputDir + "1.png", (46, 46, 46), outputDir + "1.png")


# print("当前目录：" + current_directory)


# # bgRange = [[0, 0, 100], [0, 255, 255]]  # 白色背景
# bgRange = [40, 40, 40], [69, 69, 69]  # 白色背景

# x(inputDir + r"**/*.png", bgRange, outputDir)
# x(inputDir + r"**/*.jpg", bgRange, outputDir)

# print("结束")
