var webpack = require('webpack')
var postcssImport = require('postcss-import')
var autoprefixer = require('autoprefixer')
var precss = require('precss')

module.exports = {
  entry: './index.js',
  output: {
    filename: 'bundle.js',
    publicPath: 'http://localhost:4000/'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ],
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        include: /app/,
        loaders: [
          'style',
          'css?modules',
          'postcss'
        ]
      },
      {
        test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url-loader?mimetype=image/svg+xml'
      },
      {
        test: /\.woff(\d+)?(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.(jpg|png|gif)$/,
        loader: 'file-loader?name=[name].[ext]'
      }
    ]
  },
  postcss(webpack) {
    return [
      postcssImport({
          addDependencyTo: webpack
      }),
      precss,
      autoprefixer
    ]
  },
  devServer: {
    hot: true,
    port: 4000,
    inline: true,
    historyApiFallback: true
  }
}
