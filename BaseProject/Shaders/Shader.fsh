//
//  Shader.fsh
//  BaseProject
//
//  Created by library on 8/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
